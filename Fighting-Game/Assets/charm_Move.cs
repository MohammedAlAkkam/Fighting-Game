using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class charm_Move : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject player;
    bool rotate = true;
    void Start()
    {
        Destroy(gameObject, 2);
        Invoke("Disable", 1f);
    }

    // Update is called once per frame
    void Update()
    {
        if(rotate)
        transform.LookAt(player.transform.Find("Center").position);
        transform.Translate(Vector3.forward * 15 * Time.deltaTime);
    }
    private void Disable()
    {
        rotate = false;
    }
}
