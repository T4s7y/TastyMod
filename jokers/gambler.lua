SMODS.Joker {
  key = 'gambler',
  atlas = 'tm_jokers',
  pos = { x = 0, y = 0 },
  rarity = 1, 
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,

  loc_txt = {
    name = 'Gambler',
    text = {
      'Each scored {C:attention}7{} has a',
      '{C:green}#1# in 5{} chance for {C:mult}+20{} Mult',
      'and a {C:green}#2# in 15{} chance for {C:money}+$20{}'
    }
  },

  loc_vars = function(self, info_queue, card)
    return { 
      vars = { 
        G.GAME.probabilities.normal, 
        G.GAME.probabilities.normal 
      } 
    }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:get_id() == 7 then
        local mult_triggered = false
        local dollars_triggered = false

        if pseudorandom('lucky_seven_mult') < G.GAME.probabilities.normal / 5 then
          mult_triggered = true
        end

        if pseudorandom('lucky_seven_dollars') < G.GAME.probabilities.normal / 15 then
          dollars_triggered = true
        end

        if dollars_triggered then
          ease_dollars(20)
        end

        if mult_triggered then
          return {
            mult = 20,
            card = card
          }
        end
      end
    end
  end
}
