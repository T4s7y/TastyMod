SMODS.Joker {
  key = "snowball",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perish_compat = false,
  loc_txt = {
    name = "Snowball",
    text = {
      "Gives {C:money}+$4{} at end of round",
      "per consecutive {C:attention}Blind{} won using only {C:attention}1 hand{} ",
      "{C:inactive}(Currently {C:money}+$#1#){}"
    }
  },
  config = { 
    extra = { 
      dollars_per_streak = 4, 
      streak = 0 
    } 
  },

  loc_vars = function(self, info_queue, card)
    local dollars_per = card.ability.extra.dollars_per_streak
    local current_streak = card.ability.extra.streak or 0
    return {
      vars = {
        dollars_per * current_streak,
      }
    }
  end,

calculate = function(self, card, context)
    if context.after then
      local won_round = (G.GAME.chips + math.max(0, hand_chips * mult)) >= G.GAME.blind.chips
      if not won_round and G.GAME.current_round.hands_played == 0 and card.ability.extra.streak > 0 then
        card.ability.extra.streak = 0
        return {
          message = "Reset!",
          colour = G.C.RED
        }
      end
    end

    if context.end_of_round and not context.game_over then
      if not G.GAME.streak_master_evaluated then
        G.GAME.streak_master_evaluated = true
        if G.GAME.current_round.hands_played == 1 then
          card.ability.extra.streak = card.ability.extra.streak + 1
          return {
            message = "Upgraded!",
            colour = G.C.MONEY
          }
        end
      end
    end
  end,

  calc_dollar_bonus = function(self, card)
    local current_streak = card.ability.extra.streak or 0
    local payout = current_streak * card.ability.extra.dollars_per_streak
    if payout > 0 then
      return payout
    end
  end
}

local reset_game_globals_ref = SMODS.current_mod.reset_game_globals or function() end
SMODS.current_mod.reset_game_globals = function()
  reset_game_globals_ref()
  G.GAME.streak_master_evaluated = nil
end
