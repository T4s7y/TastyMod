SMODS.Joker {
  key = "introverted_joker",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 1, 
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  config = {
    extra = {
      dollars = 1
    }
  },

  loc_txt = {
    name = "Introverted Joker",
    text = {
      "{C:money}+$#1#{} for each",
      "discarded {C:attention}face card{}"
    }
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.dollars
      }
    }
  end,

  calculate = function(self, card, context)
    if context.discard and context.other_card:is_face() then
      ease_dollars(card.ability.extra.dollars)
      
      return {
        message = "+$" .. card.ability.extra.dollars,
        colour = G.C.MONEY,
        card = card
      }
    end
  end
}
