using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using Cinemachine;
public class CameraLook : MonoBehaviour
{
    [SerializeField]InputActionReference camrotat;
    CinemachineFreeLook camera;

    void Start()
    {
        camera = GetComponent<CinemachineFreeLook>();
    }
    private void OnEnable()
    {
        camrotat.action.Enable();
    }
    private void OnDisable()
    {
        camrotat.action.Disable();

    }
    void Update()
    {
        Vector2 delta = camrotat.action.ReadValue<Vector2>();
        camera.m_XAxis.Value += delta.x * 100 * Time.deltaTime;
        camera.m_YAxis.Value += delta.y  * Time.deltaTime;
    }
}
