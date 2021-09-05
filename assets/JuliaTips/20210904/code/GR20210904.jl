# This file was generated, do not modify it. # hide
using Plots
gr()

@eval Plots begin
    function gr_polaraxes(rmin::Real, rmax::Real, sp::Subplot)
    GR.savestate()
    xaxis = sp[:xaxis]
    yaxis = sp[:yaxis]

    #α = 0:45:315    #元の定義
    α = 0:30:330    #書き換えたもの
    a = α .+ 90
    sinf = sind.(a)
    cosf = cosd.(a)
    rtick_values, rtick_labels = get_ticks(sp, yaxis, update = false)

    #draw angular grid
    if xaxis[:grid]
        gr_set_line(
            xaxis[:gridlinewidth],
            xaxis[:gridstyle],
            xaxis[:foreground_color_grid],
            sp,
        )
        gr_set_transparency(xaxis[:foreground_color_grid], xaxis[:gridalpha])
        for i in eachindex(α)
            GR.polyline([sinf[i], 0], [cosf[i], 0])
        end
    end

    #draw radial grid
    if yaxis[:grid]
        gr_set_line(
            yaxis[:gridlinewidth],
            yaxis[:gridstyle],
            yaxis[:foreground_color_grid],
            sp,
        )
        gr_set_transparency(yaxis[:foreground_color_grid], yaxis[:gridalpha])
        for i in eachindex(rtick_values)
            r = (rtick_values[i] - rmin) / (rmax - rmin)
            if r <= 1.0 && r >= 0.0
                GR.drawarc(-r, r, -r, r, 0, 359)
            end
        end
        GR.drawarc(-1, 1, -1, 1, 0, 359)
    end

    #prepare to draw ticks
    gr_set_transparency(1)
    GR.setlinecolorind(90)
    GR.settextalign(GR.TEXT_HALIGN_CENTER, GR.TEXT_VALIGN_HALF)

    #draw angular ticks
    if xaxis[:showaxis]
        GR.drawarc(-1, 1, -1, 1, 0, 359)
        for i in eachindex(α)
            x, y = GR.wctondc(1.1 * sinf[i], 1.1 * cosf[i])
            GR.textext(x, y, string((360 - α[i]) % 360, "^o"))
        end
    end

    #draw radial ticks
    if yaxis[:showaxis]
        for i in eachindex(rtick_values)
            r = (rtick_values[i] - rmin) / (rmax - rmin)
            if r <= 1.0 && r >= 0.0
                x, y = GR.wctondc(0.05, r)
                gr_text(x, y, _cycle(rtick_labels, i))
            end
        end
    end
    GR.restorestate()
end
end
x = -1:1/(1<<6):1
plot( x.*π , cospi.(3x) , proj = :polar)