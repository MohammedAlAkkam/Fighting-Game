using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    public Camera camera;
    Animator animator;
    Rigidbody rb;
    float Speed = 5;
        private void Start()
    {
        animator = GetComponent<Animator>();
        
        rb = GetComponent<Rigidbody>();
        camera = Camera.main;
    }
     void Run(Vector3 Direction)
    {
        float speed;
        if(animator.GetCurrentAnimatorStateInfo(0).IsName("Run")) 
        {
            speed = Speed;
        }
        else speed =0;
        Vector3 Dir = Direction.normalized;
        animator.SetInteger("Speed", (int)(Dir.normalized.magnitude));
        float angle = (Mathf.Atan2(Dir.y, Dir.x))* Mathf.Rad2Deg;
       // float final_angle = Mathf.SmoothDampAngle(transform.eulerAngles.y,angle,ref R_S, RotS);
        Vector3 fullDir  =speed *  Dir.magnitude* Time.fixedDeltaTime  *transform.forward;
        rb.position += (fullDir);
        if (Direction.magnitude <0.2f)
            return;
       transform.rotation = Quaternion.Euler(0, angle+  2*camera.GetComponent<Camera>().transform.parent.parent.rotation.y * Mathf.Rad2Deg,0);
    }
     void Attack()
    {
        if(animator.GetCurrentAnimatorStateInfo(0).IsTag("Attack"))
        {
            
            animator.SetTrigger("Next");
            return;
        }
        animator.Play("Attack"); 
    }
    
     void Damage()
    {
        animator.SetTrigger("Damage");
    }
}