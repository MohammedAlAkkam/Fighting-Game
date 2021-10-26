using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class attack_thrue : MonoBehaviour
{
   public GameObject volum;
    private void OnTriggerEnter(Collider collision)
    {
        if(collision.gameObject.tag == "Player")
        {
            GameObject coll = collision.gameObject;
            coll.GetComponent<Damage>().TackDamage(20);
            collision.GetComponent<Animator>().SetTrigger("Crazy");
        }
        Destroy(gameObject);

    }

}
