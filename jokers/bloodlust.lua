SMODS.Joker {
  key = "bloodlust", 
  atlas = "tm_jokers",
  loc_txt = {
    name = "Bloodlust",
    text = {
      "{X:mult,C:white}X#1#{} Mult if at least {C:attention}#2#{}",
      "cards have been destroyed this run",
      "{C:inactive}(Currently {C:attention}#3#{C:inactive}/#2#)"
    }
  },
  config = { extra = { Xmult = 3, req = 12 } },
  pos = { x = 0, y = 0 },
  rarity = 3,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,

  loc_vars = function(self, info_queue, card)
    local destroyed_count = (G.GAME and G.GAME.cards_destroyed) or 0
    return { 
      vars = { 
        card.ability.extra.Xmult, 
        card.ability.extra.req, 
        destroyed_count 
      } 
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local destroyed_count = (G.GAME and G.GAME.cards_destroyed) or 0

      if destroyed_count >= card.ability.extra.req then
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}},
          Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
  end,
}
