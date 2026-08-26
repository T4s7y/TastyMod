SMODS.Atlas {
  key = "tm_grey_seal",
  path = "grey_seal.png",
  px = 74,
  py = 95,
}

SMODS.Seal {
  key = "grey_seal",
  atlas = "tm_grey_seal",
  badge_colour = HEX("808080"),
  loc_txt = {
    name = "Grey Seal",
    label = "Grey Seal",
    text = {
      "Gives {X:mult,C:white}X#1#{} Mult when scored,",
      "increases by {X:mult,C:white}X0.1{} Mult",
      "each time this card is scored"
    }
  },
  pos = { x = 0, y = 0 },
  
  config = { x_mult = 1.0 },

  loc_vars = function(self, info_queue, card)
    local current_xmult = (card.ability.seal and card.ability.seal.x_mult) or 1.0
    return { vars = { current_xmult } }
  end,

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      card.ability.seal.x_mult = (card.ability.seal.x_mult or 1.0) + 0.1
      return {
        x_mult = card.ability.seal.x_mult
      }
    end
  end
}
