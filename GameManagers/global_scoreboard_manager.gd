extends Node2D

const SERVER_URL = "http://127.0.0.1:5000/player_stats"
@onready var http_request: HTTPRequest = $HTTPRequest


func _ready() -> void:
	http_request.request_completed.connect(_on_request_completed)
	#send_request()
	var test = {"name": "Player2", "score": 2300, "date": "2024-11-08"}
	
	#print(GameManager.all_player_list[0].player_name,GameManager.all_player_list[0].score,GameManager.all_player_list[0].date)
	
	send_post_request(test)
	
func send_request() ->void:
	var headers = ["Content-TYpe: application/json"]
	http_request.request(SERVER_URL,headers,HTTPClient.METHOD_GET)
	
func send_post_request(data) ->void:
	var json = JSON.stringify(data)
	var headers = ["Content-TYpe: application/json"]
	http_request.request(SERVER_URL,headers,HTTPClient.METHOD_POST,json)
	
func _on_request_completed(results, response_code, headers, body) ->void:
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	#print(json)
