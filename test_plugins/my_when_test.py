def in_tags(the_tag, ansible_run_tags):
    return the_tag in ansible_run_tags or "all" in ansible_run_tags

class TestModule(object):
    def tests(self):
        return {
            "in_tags": in_tags,
        }
