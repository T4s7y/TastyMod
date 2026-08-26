SMODS.Joker {
  key = "his_majesty",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 3,
  cost = 10,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,

  loc_txt = {
    name = "His Majesty",
    text = {
      "If first hand of round contains exactly {C:attention}1{} card,",
      "attach an {C:attention}Orange Seal{} to it"
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.tm_orange
    return { vars = {} }
  end,
  calculate = function(self, card, context)
    if context.before and context.full_hand and #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
      local target_card = context.full_hand[1]

      if target_card.seal ~= "tm_orange" then
        target_card:set_seal("tm_orange", nil, true)
        target_card:juice_up()

        return {
          message = "Sealed!",
          colour = G.C.ORANGE_SEAL or HEX("FF8C00")
        }
      end
    end
  end
}
