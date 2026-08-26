SMODS.Joker {
  key = "beer",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 1, 
  cost = 4,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = false,

  config = { 
    extra = { 
      discards = 1 
    } 
  },

  loc_txt = {
    name = "Beer",
    text = {
      "Sell this card to gain", 
      "{C:red}+#1#{} discard this round"
    }
  },

  loc_vars = function(self, info_queue, card)
    return { 
      vars = { 
        card.ability.extra.discards 
      } 
    }
  end,

  calculate = function(self, card, context)
    if context.selling_self then
      ease_discard(card.ability.extra.discards)

      return {
        message = "Where are my keys?",
        colour = G.C.RED
      }
    end
  end
}
