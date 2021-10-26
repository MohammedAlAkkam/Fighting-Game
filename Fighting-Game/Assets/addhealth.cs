using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class addhealth : MonoBehaviour
{
    Transform player;
    void Start()
    {

        player = GameObject.FindGameObjectWithTag("Player").transform.Find("Center").transform;
    }

    // Update is called once per frame
    void Update()
    {
         transform.LookAt(player.position);
         transform.Translate(Vector3.forward * 5 *Time.deltaTime);

    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
            player.GetComponentInParent<Damage>().Current_Health = Mathf.Clamp(player.GetComponentInParent<Damage>().Current_Health + 30, 0, 100);
        Destroy(gameObject);
    }
}
