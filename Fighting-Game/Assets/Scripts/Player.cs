using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player:MonoBehaviour
{
    private void Awake()
    {
        Application.targetFrameRate = 60;
        if (character !=null)
        {
            return;
        }
        character = this;
        DontDestroyOnLoad(gameObject);

    }
    public static Player character;
    public GameObject player;
    public int Level = 1;
    public float mony = 0;
}
