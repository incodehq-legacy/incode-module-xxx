/**
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package org.incode.module.xxx.specglue;

import java.util.List;
import java.util.UUID;

import org.apache.isis.core.specsupport.specs.CukeGlueAbstract;

import org.incode.module.xxx.dom.impl.XxxObject;
import org.incode.module.xxx.dom.impl.XxxObjectMenu;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class XxxObjectMenuGlue extends CukeGlueAbstract {

    @Given("^there are.* (\\d+) xxx objects$")
    public void there_are_N_xxx_objects(int n) throws Throwable {
        try {
            final List<XxxObject> list = menu().listAll();
            assertThat(list.size(), is(n));
            putVar("java.util.List", "xxxObjects", list);
        } finally {
            assertMocksSatisfied();
        }
    }
    
    @When("^.*create a .*xxx object$")
    public void create_a_xxx_object() throws Throwable {
        menu().create(UUID.randomUUID().toString());
    }

    private XxxObjectMenu menu() {
        return service(XxxObjectMenu.class);
    }

}
