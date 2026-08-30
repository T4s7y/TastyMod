SMODS.Joker {
  key = "donut_hole",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  config = {
    extra = {
      Xmult = 1.5
    }
  },

  loc_txt = {
    name = "Donut Hole",
    text = {
      "{C:attention}TastyMod{} Jokers",
      "each give {X:mult,C:white}X#1#{} Mult"
    }
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.Xmult
      }
    }
  end,

  calculate = function(self, card, context)
    if context.other_joker and context.other_joker ~= card then
      local other_key = context.other_joker.config.center.key or ""
      if string.sub(other_key, 1, 5) == "j_tm_" then
        G.E_MANAGER:add_event(Event({
          func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
          end
        }))

        return {
          message = "X" .. card.ability.extra.Xmult .. " Mult",
          Xmult_mod = card.ability.extra.Xmult,
          colour = G.C.MULT
        }
      end
    end
  end
}
