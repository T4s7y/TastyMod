SMODS.Atlas {
  key = "tm_la_pasion",
  path = "la_pasion.png",
  px = 71,
  py = 95
}


SMODS.Joker {
  key = "la_pasion",
  atlas = "tm_la_pasion",
  loc_txt = {
    name = "La Pasion",
    text = {
      "Gains {C:mult}+3{} Mult if played hand",
      "contains a scoring {C:attention}Queen{}",
      "{C:inactive}(Currently {C:mult}+#1#{} {C:inactive}Mult)"
    }
  },
  config = { extra = { mult = 0, mult_gain = 3 } },
  pos = { x = 0, y = 0 }, 
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perish_compat = false,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,

  calculate = function(self, card, context)
    if context.before and context.scoring_hand and not context.blueprint then
      local has_queen = false

      for _, scoring_card in ipairs(context.scoring_hand) do
        if scoring_card:get_id() == 12 then 
          has_queen = true
          break
        end
      end

      if has_queen then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
        return {
          message = "La Pasion!",
          colour = G.C.MULT
        }
      end
    end

    if context.joker_main and card.ability.extra.mult > 0 then
      return {
        message = localize{type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult }},
        mult_mod = card.ability.extra.mult
      }
    end
  end
}
