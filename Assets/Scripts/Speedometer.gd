extends Button


enum SpeedUnit {
	METERS_PER_SECOND = 0,
	KILOMETERS_PER_HOUR = 1,
	MILES_PER_HOUR = 2,
}

export(SpeedUnit) var speed_unit = 1


func _process(_delta):
	if get_parent().get_parent().has_node("Car"):
		var speed = get_parent().get_parent().get_node("Car").linear_velocity.length()
		if speed_unit == SpeedUnit.METERS_PER_SECOND:
			text = "Speed: " + ("%.1f" % speed) + " m/s"
		elif speed_unit == SpeedUnit.KILOMETERS_PER_HOUR:
			speed *= 3.6
			text = "Speed: " + ("%.0f" % speed) + " km/h"
		else: # speed_unit == SpeedUnit.MILES_PER_HOUR:
			speed *= 2.23694
			text = "Speed: " + ("%.0f" % speed) + " mph"
	if get_parent().get_parent().has_node("DriftCar"):
		var speed = get_parent().get_parent().get_node("DriftCar").get_node("Ball").linear_velocity.length()
		speed *= 3.6
		text = "Speed: " + ("%.0f" % speed) + " km/h"


func _on_Spedometer_pressed():
	speed_unit = (speed_unit + 1) % 3
