SMODS.Joker {
  key = "lackie",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 1,
  cost = 4,
  discovered = true,
  unlocked = true,
  blueprint_compat = true,

  config = {
    extra = {
      mult = 10,
      chips = 30,
      dollars = 1
    }
  },

  loc_txt = {
    name = "Lackie",
    text = {
      "{C:green}#1# in 2{} chance for {C:mult}+#2#{} Mult",
      "{C:green}#1# in 2{} chance for {C:chips}+#3#{} Chips",
      "{C:green}#1# in 2{} chance to lose {C:money}$#4#{}"
    }
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        G.GAME.probabilities.normal,
        card.ability.extra.mult,
        card.ability.extra.chips,
        card.ability.extra.dollars
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local mult_gain = 0
      local chip_gain = 0

      if pseudorandom("lackie_mult") < G.GAME.probabilities.normal / 2 then
        mult_gain = card.ability.extra.mult
      end

      if pseudorandom("lackie_chips") < G.GAME.probabilities.normal / 2 then
        chip_gain = card.ability.extra.chips
      end

      if pseudorandom("lackie_dollars") < G.GAME.probabilities.normal / 2 then
        ease_dollars(-card.ability.extra.dollars)
        card_eval_status_text(card, "extra", nil, nil, nil, {
          message = "-$" .. card.ability.extra.dollars,
          colour = G.C.MONEY
        })
      end

      if mult_gain > 0 or chip_gain > 0 then
        return {
          mult_mod = mult_gain > 0 and mult_gain or nil,
          chip_mod = chip_gain > 0 and chip_gain or nil,
          message = (mult_gain > 0 and ("+" .. mult_gain .. " Mult ") or "") .. (chip_gain > 0 and ("+" .. chip_gain .. " Chips") or ""),
          colour = mult_gain > 0 and G.C.MULT or G.C.CHIPS
        }
      end
    end
  end
}
