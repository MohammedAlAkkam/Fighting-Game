using UnityEngine;
using UnityEngine.InputSystem;
public class PlayerController : Controller
{
    public Camera cam;
    public GameObject weapen;
    [SerializeField] InputActionReference movementController;
    [SerializeField] InputActionReference RotatController;
    [SerializeField] InputActionReference attack;
    [SerializeField] InputActionReference jump;
    [SerializeField] Sword Sword;
     GameObject vfx;
    Vector3 Velicity;
    float speed = 5;
    float vfxlifetime;
    public Vector3 Direction;
    public bool IsDamage;
    bool IsJump;
    public float RotatSpeed = .2f;
    private float gravityValue = -9.81f;
    private float rs;
        
    private void OnEnable()
    {
        movementController.action.Enable();
        attack.action.Enable();
        jump.action.Enable();
        RotatController.action.Enable();
        //Cursor.lockState = CursorLockMode.Locked;
       
        //Cursor.visible = false;
    }
    private void OnDisable()
    {

        movementController.action.Disable();
        attack.action.Disable();
        jump.action.Disable();
        RotatController.action.Disable();
        Cursor.visible = true;



    }
    void Start()
    {
        cam = Camera.main;
        DamageTag = "Enemy";
        controller = GetComponent<CharacterController>();
        animator = GetComponent<Animator>();
        SetSwordSetting(Sword);
    }
    private void Update()
    {
        if (IsDathe) return;
        IsDamage = animator.GetCurrentAnimatorStateInfo(0).IsTag("Damage");

         Vector2 Dir = movementController.action.ReadValue<Vector2>();
           Direction = new Vector3(Dir.x,0,Dir.y);
       // if (Input.GetKey(KeyCode.W))
       //     Direction.z = 1;
       // if (Input.GetKey(KeyCode.S))
       //     Direction.z = -1;
       // if (Input.GetKey(KeyCode.A))
       //     Direction.x = 1;
       // if (Input.GetKey(KeyCode.W))
       //     Direction.x = -1;
        Direction.y = 0;
           IsAttack = animator.GetCurrentAnimatorStateInfo(0).IsTag("Attack");
        if (!IsAttack)
        {
            IsAttack = false;
            CanDamage = false;
        }
        if (IsDamage) return;
        IsJump =   animator.GetCurrentAnimatorStateInfo(0).IsTag("Jump");


         if (attack.action.triggered)
               Attack();
         if (controller.isGrounded || Velicity.y < 0)
         {
             Velicity.y = 0;
             if (jump.action.triggered)
                 Jump();
         }

         if(!IsAttack)
           Run(Direction);


         Velicity.y += gravityValue * Time.deltaTime;
         controller.Move(Velicity);
        
    }

     void Jump()
    {
        animator.SetTrigger("Jump");
        
    }

    void Run(Vector3 Direction)
    {

        speed = 3;
        if (IsJump) speed = 0;
        if (IsAttack)return;
        Vector3 Dir = Direction.normalized;
        animator.SetInteger("Speed", (int)(Dir.normalized.magnitude));
         Velicity = speed * Dir.magnitude * Time.deltaTime * transform.forward;
        Velicity.y = 0;
        if (Direction.magnitude < 0.1f)
        {
            return;
        }
        float angle =  (Mathf.Atan2(Dir.x, Dir.z)) * Mathf.Rad2Deg + Camera.main.transform.rotation.eulerAngles.y;
        angle = Mathf.SmoothDampAngle(transform.rotation.eulerAngles.y, angle,ref rs, .12f);

        transform.rotation = Quaternion.Euler(0, angle, 0);
    }
    void Attack()
    {

        if (IsAttack)
        {
            animator.SetTrigger("Next");
            return;
        }
        animator.SetTrigger("Attack");

    }
   public void VFXAxe()
    {

        GameObject vf = Instantiate(vfx);
        FindObjectOfType<SoundManager>().Play("Attack");
        ActivVfx pos = vf.GetComponent<ActivVfx>();
        if (pos)
            pos.SetPlayer(weapen);
         Destroy(vf, vfxlifetime);
    }

    public void VFXSword()
    {
        GameObject vf = Instantiate(vfx);
        vf.transform.position = weapen.transform.position;
        vf.transform.rotation = weapen.transform.rotation;
        FindObjectOfType<SoundManager>().Play("Attack");
        Destroy(vf, vfxlifetime);
    }

    public void SetSwordSetting(Sword item)
    {
        animator.SetInteger("WeapenId", item.ID);
        vfxlifetime = item.VFXtime;
        vfx = item.VFX;
    }
    public void SetSword(Sword i)
    {
        Sword = i;

    }
}