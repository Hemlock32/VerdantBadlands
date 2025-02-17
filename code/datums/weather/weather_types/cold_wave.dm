/datum/weather/cold_wave
	name = "cold wave"
	desc = "Harsh cold wave will grip an entire area."
	probability = 2

	telegraph_message = "<span class='notice'>A chilling and unfamiliar breeze sweeps over the surrounding area.</span>"
	telegraph_duration = 300
	telegraph_overlay = "snow_storm"
	telegraph_sound = 'sound/f13effects/sandstorm_warning.ogg'

	weather_message = "<span class='notice'>The once only chilling breeze outside rapidly falls to an unbearable cold overtime with no signs of stopping. You feel as though you are better off indoors.</span>"
	weather_overlay = "snow_storm"
	weather_duration_lower = 1200
	weather_duration_upper = 2400

	end_duration = 100
	end_message = "<span class='notice'>The cold snap dies down, it should be safe to go outside again.</span>"

	area_types = list(/area/f13/wasteland)
	protected_areas = list(/area/shuttle)
	target_trait = ZTRAIT_SURFACE
	carbon_exclusive = TRUE

	immunity_type = "snow"

	barometer_predictable = TRUE

/datum/weather/cold_wave/weather_act(mob/living/L)
	L.adjust_bodytemperature(-rand(5, 15))

/datum/weather/cold_wave/casper
	name = "casper mountain cold wave"
	area_types = list(/area/f13/mountain_area)
	probability = 10
