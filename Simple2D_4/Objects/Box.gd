tool
extends StaticBody2D


export (Texture) var BoxTexture

onready var SpriteNode: Sprite = $Sprite

func _ready() -> void:
	if (BoxTexture):
		SpriteNode.texture = BoxTexture



