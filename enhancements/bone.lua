SMODS.Atlas {
  key = "tm_bone",
  path = "bone.png",
  px = 71,
  py = 95
}

SMODS.Enhancement {
  key = "bone",
  atlas = "tm_bone", 
  pos = { x = 0, y = 0 },
  config = {},

  loc_txt = {
    name = "Bone Card",
    text = {
      "Retrigger {C:attention}1{} additional time",
      "for each other {C:attention}Bone Card{}",
      "used in scoring"
    }
  },

  calculate = function(self, card, context, effect)
    if context.repetition and context.cardarea == G.play then
      local bone_count = 0

      if context.scoring_hand then
        for i = 1, #context.scoring_hand do
          local scoring_card = context.scoring_hand[i]
          if scoring_card ~= card and scoring_card.config.center and scoring_card.config.center.key == 'm_tm_bone' then
            bone_count = bone_count + 1
          end
        end
      end

      if G.jokers and G.jokers.cards then
        for _, joker in ipairs(G.jokers.cards) do
          if joker.config.center.key == "j_tm_skeleton" and not joker.debuff then
            bone_count = bone_count + 1
          end
        end
      end

      if bone_count > 0 then
        return {
          message = 'Again!',
          repetitions = bone_count,
          card = card
        }
      end
    end
  end
}
