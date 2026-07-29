hl.layout.register("deck", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then return end
        local a = ctx.area

        if n == 1 then
            ctx.targets[1]:place(a)
            return
        end

        local mw = math.floor(a.w * 0.55)

        ctx.targets[1]:place({x = a.x, y = a.y, w = mw, h = a.h})

        for i = 2, n do
            ctx.targets[i]:place({x = -9999, y = -9999, w = 1, h = 1})
        end
    end,
})
