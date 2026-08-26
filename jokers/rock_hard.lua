SMODS.Joker {
  key = "rock_hard",
  atlas = "tm_jokers",
  loc_txt = {
    name = "Rock Hard",
    text = {
      "At the start of each round", 
      "draw all of your {C:attention}Stone Cards{}",
      "Retrigger all played {C:attention}Stone Cards{}"
    }
  },
  config = { extra = { retriggers = 1 } },
  pos = { x = 0, y = 0 }, 
  rarity = 3,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    return { vars = { card.ability.extra.retriggers } }
  end,

  calculate = function(self, card, context)
    if context.first_hand_drawn then
      local stone_cards = {}

      for _, deck_card in ipairs(G.deck.cards) do
        if deck_card.ability.effect == "Stone Card" then
          stone_cards[#stone_cards + 1] = deck_card
        end
      end

      if #stone_cards > 0 then
        card:juice_up(0.8, 0.5)

        G.E_MANAGER:add_event(Event({
          func = function()
            for _, target_card in ipairs(stone_cards) do
              draw_card(G.deck, G.hand, 100, 'up', nil, target_card)
            end
            return true
          end
        }))

        return {
          message = "Rock Hard!",
          colour = G.C.GREY
        }
      end
    end

    if context.repetition and context.cardarea == G.play then
      if context.other_card.ability.effect == "Stone Card" then
        return {
          message = localize('k_again_ex'),
          repetitions = card.ability.extra.retriggers,
          card = card
        }
      end
    end
  end
}
