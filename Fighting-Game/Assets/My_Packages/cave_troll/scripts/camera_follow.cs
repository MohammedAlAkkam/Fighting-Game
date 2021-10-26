using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class camera_follow : MonoBehaviour {

	public GameObject Player;
	Vector3 offset;

	void Start () {
		Player = GameObject.FindGameObjectWithTag("Player");
	}
	
	// Update is called once per frame
	 void FixedUpdate()
	{
		transform.position = Player.transform.position;
	}
}
