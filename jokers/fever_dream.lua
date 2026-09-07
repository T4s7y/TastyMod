SMODS.Joker {
  key = "fever_dream",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 1,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,

  config = {
    extra = {
      dollars = 10
    }
  },

  loc_txt = {
    name = "Fever Dream",
    text = {
      "Earn {C:money}$#1#{} whenever",
      "a {C:attention}Joker{} is debuffed"
    }
  },

  loc_vars = function(self, info_queue, card)
    return { vars = { (card.ability and card.ability.extra and card.ability.extra.dollars) or 10 } }
  end
}
