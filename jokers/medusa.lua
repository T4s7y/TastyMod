SMODS.Joker {
  key = "medusa",
  atlas = "tm_jokers",
  loc_txt = {
    name = "Medusa",
    text = {
      "Turns all {C:attention}played cards{}",
      "into {C:attention}Stone Cards{}",
      "on the {C:attention}first hand{} of the round"
    }
  },
  config = {},
  pos = { x = 6, y = 0 },
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    return { vars = {} }
  end,
  calculate = function(self, card, context)
    if context.before and G.GAME.current_round.hands_played == 0 then

      if context.scoring_hand then
        for _, scoring_card in ipairs(context.scoring_hand) do
          scoring_card:set_ability(G.P_CENTERS.m_stone, nil, true)
        end
      end

      G.E_MANAGER:add_event(Event({
        func = function()
          if G.play and G.play.cards then
            for _, scoring_card in ipairs(G.play.cards) do
              scoring_card:juice_up()
            end
          end
          return true
        end
      }))

      return {
        message = "Stoned!",
        colour = G.C.GREY
      }
    end
  end
}
