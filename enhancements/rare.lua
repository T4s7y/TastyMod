SMODS.Enhancement {
  key = "rare",
  atlas = "tm_jokers", 
  pos = { x = 0, y = 0 },

  loc_txt = {
    name = "Rare Card",
    text = {
      "After scoring this card {C:attention}5{} times",
      "{C:attention}destroy{} it and create a random",
      "{C:rare}Rare{} Joker",
      "{C:inactive}(Currently #1#/5){}"
    }
  },

  set_ability = function(self, card, initial, delay_sprites)
    card.ability.rare_scores = card.ability.rare_scores or 0
  end,

  loc_vars = function(self, info_queue, card)
    local count = card and card.ability and card.ability.rare_scores or 0
    return { vars = { count } }
  end,

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      card.ability.rare_scores = (card.ability.rare_scores or 0) + 1
      if card.ability.rare_scores >= 5 then
        card.destroyed = true
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.4,
          func = function()
            if #G.jokers.cards < G.jokers.config.card_limit then
              play_sound("timpani")
              local rare_joker = create_card("Joker", G.jokers, nil, 0.99, nil, nil, nil, "rare_enhancement")
              rare_joker:add_to_deck()
              G.jokers:emplace(rare_joker)
            end
            card:start_dissolve()
            G.play:remove_card(card)
            card:remove()
            return true
          end
        }))
      end
    end
  end
}
