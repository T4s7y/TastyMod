SMODS.Joker {
  key = "astrologist",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 7,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  config = {
    extra = {
      Xmult_mod = 0.4
    }
  },

  loc_txt = {
    name = "Astrologist",
    text = {
      "Gains {X:mult,C:white}X#1#{} Mult for each",
      "{C:spectral}Spectral{} card used this run",
      "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult)"
    }
  },

  loc_vars = function(self, info_queue, card)
    local current_xmult = 1 + ((G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0) * card.ability.extra.Xmult_mod)
    return {
      vars = {
        card.ability.extra.Xmult_mod,
        current_xmult
      }
    }
  end,

  calculate = function(self, card, context)
    if context.using_consumeable and not context.blueprint then
      if context.consumeable.ability.set == "Spectral" then
        G.E_MANAGER:add_event(Event({
          func = function()
            return true
          end
        }))
      end
    end

    if context.joker_main then
      local current_xmult = 1 + ((G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0) * card.ability.extra.Xmult_mod)
      if current_xmult > 1 then
        return {
          message = "X" .. current_xmult .. " Mult",
          Xmult_mod = current_xmult,
          colour = G.C.MULT
        }
      end
    end
  end
}
