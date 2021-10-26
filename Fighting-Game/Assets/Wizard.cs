using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wizard : Controller
{
    GameObject player;
    Vector3 Dir;
    public float DistanceToAttack;

    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
        player = GameObject.FindGameObjectWithTag("Player");
    }

    // Update is called once per frame
    void Update()
    {
         Dir = (transform.position - player.transform.position).normalized;
        transform.LookAt(player.transform.position, Vector3.up);
        if (Vector3.Distance(transform.position, player.transform.position) <= DistanceToAttack)
        {
            animator.SetTrigger("Fire");
        }
        RotatToPlayer();
    }
    void RotatToPlayer()
    {
        Quaternion rotat = Quaternion.LookRotation(Dir);
        Vector3 rotatDir = rotat.eulerAngles;
        transform.rotation = Quaternion.Euler(0, rotatDir.y, 0);

    }
}
