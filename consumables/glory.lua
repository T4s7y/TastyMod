SMODS.Atlas {
  key = "tm_glory",
  path = "glory.png",
  px = 71,
  py = 95
}

SMODS.Consumable {
  set = "Spectral",
  key = "glory",
  atlas = "tm_glory", 
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "Glory",
    text = {
      "Add an {C:attention}Orange Seal{}",
      "to {C:attention}1{} selected card"
    }
  },
  cost = 4,
  unlocked = true,
  discovered = true,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.tm_orange
    return { vars = {} }
  end,

  use = function(self, card, area, copier)
    local target = G.hand.highlighted[1]
    if target then
      G.E_MANAGER:add_event(Event({
        func = function()
          target:set_seal("tm_orange", nil, true)
          target:juice_up()
          play_sound('tarot1')
          return true
        end
      }))
    end
  end,

  can_use = function(self, card)
    return G.hand and #G.hand.highlighted == 1
  end

}
