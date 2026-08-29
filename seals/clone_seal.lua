SMODS.Atlas {
  key = "tm_clone_seal",
  path = "clone_seal.png",
  px = 71,
  py = 95
}

SMODS.Seal {
  key = "clone_seal",
  atlas = "tm_clone_seal",
  pos = { x = 0, y = 0 },
  badge_colour = 
  SMODS.Gradient {
    key = "red_to_blue",
    colours = {
      G.C.RED,
      G.C.BLUE  
    },
    cycle = 2,           
    interpolation = 'trig'
  },

  loc_txt = {
    name = "Clone Seal",
    label = "Clone Seal",
    text = {
      "When this card is scored",
      "create a {C:attention}copy{} of it",
      "{C:inactive}(Can only trigger once per round){}"
    }
  },

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play and not context.retrigger_joker then
      local copied_card = create_card("Base", G.CUST_DYN, nil, nil, false, true, nil, "clone")
      copied_card:set_base(card.config.card)

      if card.ability.effect ~= "Base" then
        copied_card:set_ability(G.P_CENTERS[card.config.center.key], nil, true)
      end
      if card.edition then
        copied_card:set_edition(card.edition, true, true)
      end
      if card.seal then
        copied_card:set_seal(card.seal, true)
      end

      table.insert(G.playing_cards, copied_card)
      copied_card:add_to_deck()
      table.insert(G.discard.cards, copied_card)

      card:juice_up(0.4, 0.4)
      play_sound("tarot2")
      return {
        message = "Copied!",
        colour = G.C.BLUE
      }
    end
  end
}
