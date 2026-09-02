SMODS.Atlas {
  key = "tm_calcium",
  path = "calcium.png",
  px = 71,
  py = 95
}

SMODS.Consumable {
  key = "calcium",
  set = "Scraps", 
  atlas = "tm_calcium", 
  pos = { x = 0, y = 0 },
  cost = 3,
  unlocked = true,
  discovered = true,
  loc_txt = {
    name = "Calcium",
    text = {
      "Enhances {C:attention}1{} ",
      "selected card",
      "to {C:attention}Bone Card{}"
    }
  },
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_tm_bone
    return { vars = {} }
  end,

  can_use = function(self, card)
    return #G.hand.highlighted == 1
  end,

  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.3, 0.5)

        local target = G.hand.highlighted[1]
        target:flip()
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.5,
      func = function()
        play_sound("tarot2")
        local target = G.hand.highlighted[1]
        
        target:set_ability(G.P_CENTERS.m_tm_bone, nil, true)
        target:flip()
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        G.hand.highlighted[1]:juice_up(0.3, 0.3)
        G.hand:unhighlight_all()
        return true
      end
    }))
  end
}
