SMODS.Joker {
  key = "bank",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 2, 
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = false, 

  config = {
    extra = {
      stored_money = 0,
      interest_rate = 1.20
    }
  },

  loc_txt = {
    name = "Bank",
    text = {
      "All money earned gets stored in this joker",
      "stored money increases by {C:attention}20%{}",
      "at the end of each round",
      "sell this joker to earn all stored money",
      "{C:inactive}(Stored money {C:money}$#1#{C:inactive})"
    }
  },
loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.stored_money
      }
    }
  end,

  calculate_dollar_bonus = function(self, card)
    if card.ability.extra.stored_money > 0 then
      return card.ability.extra.stored_money
    end
  end,

  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      if G.GAME.chips >= G.GAME.blind.chips and card.ability.extra.stored_money > 0 then
        local interest = math.floor(card.ability.extra.stored_money * (card.ability.extra.interest_rate - 1))
        if interest > 0 then
          card.ability.extra.stored_money = card.ability.extra.stored_money + interest

          return {
            message = "+$" .. interest .. " Interest!",
            colour = G.C.MONEY
          }
        end
      end
    end
  end
}

local sell_card_ref = Card.sell_card
function Card:sell_card()
  if self.config.center.key == "j_tm_bank" and self.ability.extra and self.ability.extra.stored_money > 0 then
    local stored = self.ability.extra.stored_money
    G.GAME.bank_payout = true
    ease_dollars(stored)
    G.GAME.bank_payout = false
    card_eval_status_text(self, "extra", nil, nil, nil, {
      message = "+$" .. stored,
      colour = G.C.MONEY
    })
  end

  sell_card_ref(self)
end

local ease_dollars_ref = ease_dollars
function ease_dollars(amount, instant)
  if G.GAME and G.GAME.bank_payout then
    ease_dollars_ref(amount, instant)
    return
  end
  if amount and amount > 0 and G.STAGE == G.STAGES.RUN then
    if G.jokers and G.jokers.cards then
      for _, joker in ipairs(G.jokers.cards) do
        if joker.config.center.key == "j_tm_bank" then
          joker.ability.extra.stored_money = joker.ability.extra.stored_money + amount

          card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = "+$" .. amount .. " Stored",
            colour = G.C.MONEY
          })

          return
        end
      end
    end
  end
  ease_dollars_ref(amount, instant)
end

