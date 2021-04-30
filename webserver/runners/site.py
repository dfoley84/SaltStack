
import salt.client
import requests


client = salt.client.get_local_client('/etc/salt/master.d/runner')

def is_up():
    web = client.cmd('roles:webserver', 'network.ip_addrs', timeout=1)
    allUp = True

    for key, value in webserver.iteritems():
        print("IP Address {}:{}".format(key,value[0]))
        response= requests.get("http://" + value[0])
        if response.status_code == 200:
            continue
        else:
            allUp = False
    return allUp
