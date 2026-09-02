SMODS.Atlas {
  key = "tm_skeleton",
  path = "skeleton.png",
  px = 71,
  py = 95
}

SMODS.Joker {
  key = "skeleton",
  atlas = "tm_skeleton", 
  pos = { x = 0, y = 0 },
  rarity = 3,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  loc_txt = {
    name = "Skeleton",
    text = {
      "Played {C:attention}Bone Cards{} give",
      "{X:mult,C:white}X1.1{} Mult when scored",
      "Counts as a {C:attention}Bone Card{}",
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_tm_bone
    return { vars = {} }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local other_card = context.other_card
      if other_card and other_card.config.center and other_card.config.center.key == "m_tm_bone" then
        return {
          x_mult = 1.1,
          colour = G.C.MULT,
          card = card
        }
      end
    end
  end
}
