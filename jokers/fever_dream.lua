SMODS.Joker {
  key = "fever_dream",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  config = {
    extra = {
      dollars = 10,
      x_mult = 1.5
    }
  },

  loc_txt = {
    name = "Fever Dream",
    text = {
      "Earn {C:money}$#1#{} whenever",
      "a Joker is {C:attention}debuffed{}",
      "Each {C:attention}debuffed Joker{} gives {X:mult,C:white}X#2#{} Mult",
      "{C:attention}Debuff{} a random Joker after defeating",
      "the {C:attention}Boss Blind{}"
    }
  },

  loc_vars = function(self, info_queue, card)
    local dollars = (card.ability and card.ability.extra and card.ability.extra.dollars) or 10
    local x_mult = (card.ability and card.ability.extra and card.ability.extra.x_mult) or 1.5
    return { vars = { dollars, x_mult } }
  end,

  calculate = function(self, card, context)
    if context.other_joker and context.other_joker.debuff then
      return {
        message = "X" .. card.ability.extra.x_mult .. " Mult",
        Xmult_mod = card.ability.extra.x_mult,
        card = card
      }
    end

    if context.end_of_round and G.GAME.blind and G.GAME.blind.boss and not context.blueprint then
      local valid_jokers = {}

      if G.jokers and G.jokers.cards then
        for _, j in ipairs(G.jokers.cards) do
          if j ~= card and not j.debuff then
            table.insert(valid_jokers, j)
          end
        end
      end

      if #valid_jokers > 0 then
        local target = pseudorandom_element(valid_jokers, pseudoseed("fever_dream_debuff"))
        if target then
          target.ability.custom_debuff = true
          target:set_debuff(true)

          card_eval_status_text(target, "extra", nil, nil, nil, {
            message = "Debuffed!",
            colour = G.C.RED
          })
        end
      end
    end
  end
}
