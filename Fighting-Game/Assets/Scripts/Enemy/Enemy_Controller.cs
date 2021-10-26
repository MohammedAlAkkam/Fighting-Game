using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy_Controller : Controller
{
    public enum Enemy
    {
        Simple,
        Wizerd
    }
    public Enemy EnemyType;
    public GameObject Weapen_Container;
    public GameObject Charm; 
    public float DistanceToAttack = 10;
    public float DistanceToGo = 0;
    GameObject player;
    Controller playercontroller;
    Vector3 Dir;
    // Start is called before the first frame update
    void Awake()
    {
        DamageTag = "Player";
        player = GameObject.FindWithTag("Player");
    }
    private void Start()
    {
        if (EnemyType == Enemy.Simple)
        {
            DistanceToGo = 10;
            DistanceToAttack = 2.7f;
        }
        animator = GetComponent<Animator>();
        playercontroller = player.GetComponent<PlayerController>();
        controller = GetComponent<CharacterController>();

    }
    // Update is called once per frame
    void Update()
    {
        
        if (IsDathe) return;
        IsAttack = animator.GetCurrentAnimatorStateInfo(0).IsTag("Attack");
        if (IsAttack)
            return;
        else CanDamage = false;
        
         Dir = (player.transform.position - transform.position);
   
        if (Vector3.Distance(transform.position, player.transform.position) <= DistanceToAttack)
        {
            if (playercontroller.IsDathe) return;
             animator.SetTrigger("attack");
            animator.SetInteger("Speed",0);

        }
        else if (Vector3.Distance(transform.position, player.transform.position) < DistanceToGo)
        {
            animator.SetInteger("Speed",1);
            controller.Move(Dir.normalized * 3 * Time.deltaTime);
        }
        else animator.SetInteger("Speed",0);
        RotatToPlayer();

    }
    void RotatToPlayer()
    {
        Quaternion rotat = Quaternion.LookRotation(Dir);
        Vector3 rotatDir = rotat.eulerAngles;
        transform.rotation = Quaternion.Euler(0, rotatDir.y, 0);
        
    }

    public void FireCharm()
    {
        Instantiate(Charm, Weapen_Container.transform.position, Weapen_Container.transform.rotation).GetComponent<charm_Move>().player = player;
    }
}
