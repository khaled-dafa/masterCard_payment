/*
 * Copyright (c) 2016 Mastercard
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package sdk;


import com.mastercard.gateway.android.sdk.api.UpdateSessionResponse;

public interface GatewayCallback extends com.mastercard.gateway.android.sdk.api.GatewayCallback<UpdateSessionResponse> {

    /**
     * Callback on a successful call to the Gateway API
     *
     * @param response A response map
     */
    void onSuccess(GatewayMap response);

    /**
     * Callback executed when error thrown during call to Gateway API
     *
     * @param throwable The exception thrown
     */
    void onError(Throwable throwable);
}
