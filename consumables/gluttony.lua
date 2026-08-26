SMODS.Consumable {
  key = "gluttony", 
  set = "Spectral",
  atlas = "tm_jokers", 
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "Gluttony",
    text = {
      "Add a {C:attention}Grey Seal{}",
      "to {C:attention}1{} selected card"
    }
  },
  cost = 4,
  unlocked = true,
  discovered = true,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.tm_grey_seal
    return { vars = {} }
  end,

  use = function(self, card, area, copier)
    local target = G.hand.highlighted[1]
    G.E_MANAGER:add_event(Event({
      func = function()
        target:set_seal('tm_grey_seal', nil, true)
        target:juice_up()
        play_sound('tarot1')
        return true
      end
    }))
  end,

  can_use = function(self, card)
    return G.hand and #G.hand.highlighted == 1
  end
}
