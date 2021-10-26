using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
[CreateAssetMenu(fileName = "Level", menuName = "Card / Level")]
public class Level: ScriptableObject
{
    public Sprite image;
    public Scene scene;
    public bool IsOpen;

}

