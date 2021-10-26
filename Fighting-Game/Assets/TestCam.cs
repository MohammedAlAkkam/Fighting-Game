using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class TestCam : MonoBehaviour
{
    PlayerController dir;
    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        dir = GameObject.FindGameObjectWithTag("Player").GetComponent<PlayerController>();
        GetComponent<Text>().text = dir.cam.gameObject.transform.rotation.y.ToString();//dir.x + "  " + dir.z;
    }
}
