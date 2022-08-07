extends Control

var credits: Dictionary = {
	"Isometric Tileset Kenney": "https://www.kenney.nl/assets/isometric-miniature-prototype",
	"Player Model": "https://erikari.itch.io/elements-supremacy-assets",
	"Coin Icon UI": "https://icons8.de/icon/Bnal8CzCxL55/coin",
	"Stopwatch Icon UI": "https://icons8.de/icon/12999/zeit",
	"Coin Isometric": "https://www.shutterstock.com//de/image-vector/coin-lowpoly-perspective-3d-animation-sprite-510834247",
	"Title Image": "https://de.cooltext.com/",
	"Music & Sound effects by Eric Matyas": "https://soundimage.org"
}

@onready var grid: GridContainer = $GridContainer

func _ready():
	for credit_name in credits:
		var label = Label.new()
		label.text = credit_name
		grid.add_child(label)
		
		var richLabel = RichTextLabel.new()
		richLabel.bbcode_enabled = true
		richLabel.text = "[url]" + credits[credit_name] + "[/url]"
		richLabel.connect("meta_clicked", self._on_rich_text_label_meta_clicked)
		richLabel.size_flags_horizontal = SIZE_EXPAND_FILL
		richLabel.scroll_active = false
		grid.add_child(richLabel)
	$BackButton.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(meta)


func _on_welcome_screen_button_pressed():
	SceneTransition.change_scene("res://main.tscn")
