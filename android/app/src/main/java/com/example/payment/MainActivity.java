package com.example.payment;



import android.app.Activity;
import android.content.Intent;



import androidx.annotation.NonNull;

import com.google.android.gms.wallet.PaymentsClient;
import com.mastercard.gateway.android.sdk.api.UpdateSessionResponse;


import org.json.JSONObject;


import java.util.Arrays;
import java.util.Objects;
import java.util.UUID;


import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import sdk.Gateway;
import sdk.Gateway3DSecureCallback;
import sdk.GatewayCallback;
import sdk.GatewayMap;


public class MainActivity extends FlutterActivity {
    private String channel = "com.example.payment/payment/channel";
    private  String nameOnCard = "Test Tester";
    private  String cardNumber = "5123450000000008";
    private  String cardCvv = "100";
    private  String cardExpiryMM = "01";
    private  String cardExpiryYY = "39";
    private static final String EXTRA_PREFIX = "com.mastercard.gateway.sample.EXTRA_";

    public static final String EXTRA_GOOGLE_PAY_TXN_AMOUNT = EXTRA_PREFIX + "GOOGLE_PAY_TXN_AMOUNT";
    public static final String EXTRA_GOOGLE_PAY_TXN_CURRENCY = EXTRA_PREFIX + "GOOGLE_PAY_TXN_CURRENCY";

    public static final String EXTRA_CARD_DESCRIPTION = EXTRA_PREFIX + "CARD_DESCRIPTION";
    public static final String EXTRA_CARD_NAME = EXTRA_PREFIX + "CARD_NAME";
    public static final String EXTRA_CARD_NUMBER = EXTRA_PREFIX + "CARD_NUMBER";
    public static final String EXTRA_CARD_EXPIRY_MONTH = EXTRA_PREFIX + "CARD_EXPIRY_MONTH";
    public static final String EXTRA_CARD_EXPIRY_YEAR = EXTRA_PREFIX + "CARD_EXPIRY_YEAR";
    public static final String EXTRA_CARD_CVV = EXTRA_PREFIX + "CARD_CVC";
    public static final String EXTRA_PAYMENT_TOKEN = EXTRA_PREFIX + "PAYMENT_TOKEN";

    static final int REQUEST_CARD_INFO = 100;

    // static for demo
    static final String AMOUNT = "1.00";
    static final String CURRENCY = "USD";
    private  String sessionId , orderId, transactionId;
    ApiController apiController =  ApiController.getInstance();
    ProcessPaymentActivity processPaymentActivity = new ProcessPaymentActivity();
    PaymentsClient paymentsClient;
    Gateway gateway;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        new MethodChannel(messenger, channel)
                .setMethodCallHandler(((call, result) -> {
                    sessionId = call.argument("sessionId");
            if(Objects.equals(call.method, "payment")){
                Config.MERCHANT_URL.setValue(this , "http://api.tuxedo.dev.dafa.sa:3000");
              apiController.setMerchantServerUrl(Config.MERCHANT_URL.getValue(this));
                gateway = new Gateway();
                gateway.setMerchantId(Config.MERCHANT_ID.getValue(this));
                // random order/txn IDs for example purposes
                orderId = UUID.randomUUID().toString();
                orderId = orderId.substring(0, orderId.indexOf('-'));
                transactionId = UUID.randomUUID().toString();
                transactionId = transactionId.substring(0, transactionId.indexOf('-'));
                // generate a random 3DSecureId for testing
                String threeDSId = UUID.randomUUID().toString();
                threeDSId = threeDSId.substring(0, threeDSId.indexOf('-'));

                Gateway gateway = new Gateway();
                gateway.setMerchantId("3000000642");
                gateway.setRegion(Gateway.Region.NORTH_AMERICA);
                GatewayCallback callback = new GatewayCallback() {
                    @Override
                    public void onSuccess(GatewayMap response) {
                        // TODO handle success
                    }

                    @Override
                    public void onSuccess(UpdateSessionResponse response) {
                        // TODO handle success
                    }

                    @Override
                    public void onError(Throwable throwable) {
                        // TODO handle error
                    }
                };
                GatewayMap request = new GatewayMap()
                        .set("sourceOfFunds.provided.card.nameOnCard", nameOnCard)
                        .set("sourceOfFunds.provided.card.number", cardNumber)
                        .set("sourceOfFunds.provided.card.securityCode", cardCvv)
                        .set("sourceOfFunds.provided.card.expiry.month", cardExpiryMM)
                        .set("sourceOfFunds.provided.card.expiry.year", cardExpiryYY);

                gateway.updateSession(sessionId ,"39" ,request , callback);
//                paymentsClient = Wallet.getPaymentsClient(this, new Wallet.WalletOptions.Builder()
//                        .setEnvironment(WalletConstants.ENVIRONMENT_TEST)
//                        .build());
//                apiController.completeSession(sessionId ,orderId ,transactionId,AMOUNT , CURRENCY , threeDSId, false , new ProcessPaymentActivity.CompleteSessionCallback());
//                apiController.check3DSecureEnrollment(sessionId, AMOUNT, CURRENCY, threeDSId,new ProcessPaymentActivity.Check3DSecureEnrollmentCallback());

            result.success("success");
            }else {
                result.notImplemented();
            }
        }
        ));

        }

    void continueButtonClicked() {
        Intent i = new Intent();
        i.putExtra(EXTRA_CARD_DESCRIPTION, maskCardNumber(cardNumber));
        i.putExtra(EXTRA_CARD_NAME, nameOnCard);
        i.putExtra(EXTRA_CARD_NUMBER, cardNumber);
        i.putExtra(EXTRA_CARD_EXPIRY_MONTH, cardExpiryMM);
        i.putExtra(EXTRA_CARD_EXPIRY_YEAR, cardExpiryYY);
        i.putExtra(EXTRA_CARD_CVV, cardCvv);

        setResult(Activity.RESULT_OK, i);
        finish();
    }
    void returnCardInfo(JSONObject paymentData) {
        Intent i = new Intent();
        try {
            JSONObject paymentMethodData = paymentData.getJSONObject("paymentMethodData");
            String description = paymentMethodData.getString("description");
            String token = paymentMethodData.getJSONObject("tokenizationData")
                    .getString("token");

            i.putExtra(EXTRA_CARD_DESCRIPTION, description);
            i.putExtra(EXTRA_PAYMENT_TOKEN, token);

            setResult(Activity.RESULT_OK, i);
        } catch (Exception e) {
            setResult(Activity.RESULT_CANCELED, i);
        }

        finish();
    }
    String maskCardNumber(String number) {
        int maskLen = number.length() - 4;
        char[] mask = new char[maskLen];
        Arrays.fill(mask, '*');
        return new String(mask) + number.substring(maskLen);
    }

    }


