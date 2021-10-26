using System.Collections;

using System.Collections.Generic;

using UnityEngine;
using UnityEngine.Animations;

public class multiAttac : StateMachineBehaviour
{
    bool Attack = false;
    //bool Up = false;
    // OnStateEnter is called when a transition starts and the state machine starts to evaluate this state
     public  override  void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    {
        //Up = false;
        Attack = false;
        animator.GetComponent<Controller>().IsAttack = true;
    }

    // OnStateUpdate is called on each Update frame between OnStateEnter and OnStateExit callbacks
    override public void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    {

        if (Input.GetMouseButtonUp(0))
        {
            //Up = true;  
        }
        if (Input.GetMouseButtonDown(0)/* &&Up*/)
        {
            animator.SetTrigger("Plus");
            Attack = true;
        }
    }

    // OnStateExit is called when a transition ends and the state machine finishes evaluating this state
    override public void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    {
        if (stateInfo.IsTag("LastAttack"))
        {
            Attack = false;
        }
        animator.GetComponent<Controller>().IsAttack = Attack;
    }
    public override void OnStateMove(Animator animator, AnimatorStateInfo stateInfo, int layerIndex, AnimatorControllerPlayable controller)
    {
       // animator.GetComponent<Controller>().IsAttack = false;
    }

    // OnStateIK is called right after Animator.OnAnimatorIK()
    //override public void OnStateIK(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    //{
    //    // Implement code that sets up animation IK (inverse kinematics)
    //}
}
