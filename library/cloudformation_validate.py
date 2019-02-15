from ansible.module_utils.basic import AnsibleModule
import ansible.module_utils.ec2
import boto3

def main():
    argument_spec = ansible.module_utils.ec2.ec2_argument_spec()
    argument_spec.update(dict(
        template=dict(default=None, required=False, type='path')
    )
    )
    module = AnsibleModule(
        argument_spec=argument_spec,
    )
    parameters = {}
    parameters['TemplateBody'] = open(module.params['template'], 'r').read()
    client = boto3.client('cloudformation')

    try:
        result = client.validate_template(**parameters)
    except Exception as err:
        error_msg = err.message
        module.fail_json(msg=error_msg)
    module.exit_json(**result)

if __name__ == '__main__':
    main()
