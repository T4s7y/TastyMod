SMODS.Atlas {
  key = "tm_thirst",
  path = "thirst.png",
  px = 71,
  py = 95
}

SMODS.Consumable {
  key = "thirst",
  set = "Scraps",
  atlas = "tm_thirst", 
  pos = { x = 0, y = 0 },
  cost = 3,
  unlocked = true,
  discovered = true,
  config = {
    max_highlighted = 1
  },

  loc_txt = {
    name = "Thirst",
    text = {
      "Enhances {C:attention}1{} selected card",
      "to {C:mult}Blood Card{}, or raises",
      "its {C:attention}Blood Tier{} by {C:attention}+1{}"
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_tm_blood
    return { vars = {} }
  end,

  use = function(self, card, area, copier)
    local target = G.hand.highlighted[1]

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.5, 0.5)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.15,
      func = function()
        target:flip()
        play_sound("card1", 1)
        target:juice_up(0.3, 0.3)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        apply_blood_to_card(target)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.25,
      func = function()
        target:flip()
        play_sound("tarot2", 1, 0.6)
        return true
      end
    }))
  end,

  can_use = function(self, card)
    if #G.hand.highlighted ~= 1 then return false end
    local target = G.hand.highlighted[1]
    
    local is_blood = target.ability and target.ability.effect == "Blood Card" or (target.config.center and target.config.center.key == "m_tm_blood")
    if is_blood and (target.ability.blood_tier or 1) >= 3 then
      return false
    end
    
    return true
  end
}
