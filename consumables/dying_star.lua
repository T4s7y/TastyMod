SMODS.Consumable {
  key = "dying_star",
  set = "Spectral",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  cost = 4,
  unlocked = true,
  discovered = true,

  loc_txt = {
    name = "Dying Star",
    text = {
      "Add a {C:purple}Void Seal{}",
      "to {C:attention}1{} selected card",
      "in your hand"
    }
  },

  loc_vars = function(self, info_queue, card)
    if G.P_SEALS and G.P_SEALS.tm_void_seal then
      info_queue[#info_queue + 1] = G.P_SEALS.tm_void_seal
    end
    return { vars = {} }
  end,

  can_use = function(self, card)
    return G.hand and #G.hand.highlighted == 1
  end,

  use = function(self, card, area, copier)
    local selected_card = G.hand.highlighted[1]

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        selected_card:juice_up(0.8, 0.5)
        selected_card:set_seal('tm_void_seal', nil, true)
        return true
      end
    }))
  end
}
