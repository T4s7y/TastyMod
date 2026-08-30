SMODS.Joker {
  key = "emergency_slippers",
  atlas = "tm_jokers", 
  pos = { x = 0, y = 0 },
  rarity = 2, 
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  perish_compat = false,

  config = {
    extra = {
      chips = 0,
      chip_mod = 20
    }
  },

  loc_txt = {
    name = "Emergency Slippers",
    text = {
      "This joker gains {C:chips}+#2#{} Chips if played",
      "hand contains a {C:attention}Three of a Kind{}",
      "{C:inactive}(Currently {C:chips}+#1#{} {C:inactive}Chips)"
    }
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.chips,
        card.ability.extra.chip_mod
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local has_3oak = false
      if context.poker_hands then
        for hand_name, hand_list in pairs(context.poker_hands) do
          if hand_name == "Three of a Kind" and #hand_list > 0 then
            has_3oak = true
            break
          end
        end
      end

      if has_3oak then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod

        card_eval_status_text(card, "extra", nil, nil, nil, {
          message = "Upgraded!",
          colour = G.C.CHIPS
        })
      end
      if card.ability.extra.chips > 0 then
        return {
          chip_mod = card.ability.extra.chips,
          message = "+" .. card.ability.extra.chips,
          colour = G.C.CHIPS
        }
      end
    end
  end
}
