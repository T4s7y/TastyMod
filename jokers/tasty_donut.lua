SMODS.Joker {
  key = "tasty_donut", 
  atlas = "tm_jokers",
  loc_txt = {
    name = "Tasty Donut",
    text = {
      "{C:blue}+#1#{} hands,",
      "loses {C:blue}1{} hand",
      "at end of round"
    }
  },
  config = { extra = { hands = 5 } },
  pos = { x = 0, y = 0 },
  rarity = 3,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = false,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.hands } }
  end,

  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if G.GAME.current_round then
      ease_hands_played(card.ability.extra.hands)
    end
  end,

  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    if G.GAME.current_round then
      ease_hands_played(-card.ability.extra.hands)
    end
  end,

  calculate = function(self, card, context)
    if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
      card.ability.extra.hands = card.ability.extra.hands - 1
      G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1

      if card.ability.extra.hands <= 0 then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            card:start_dissolve()
            return true
          end
        }))
        return {
          message = localize('k_eaten_ex'),
          colour = G.C.FILTER
        }
      else
        return {
          message = "-1 Hand",
          colour = G.C.BLUE
        }
      end
    end
  end
}
