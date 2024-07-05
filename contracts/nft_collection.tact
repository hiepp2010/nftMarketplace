import "@stdlib/deploy";
import "@stdlib/ownable";


contract NftCollection with Deployable ,Ownable{
    // Empty init() function is present by default in all Tact contracts
    // since v1.3.0, so the following may be omitted:
    //
    // init() {}

    owner: Address;
    nextItemIndex: Int as unit32 = 0;
    collectionContent: String;
    collectionIndex: Int as unit32;
    
    init(owner: Address, collectionContent: String, collectionIndex: Int as unit32){
        self.owner=sender();
        self.collectionContent = collectionContent;
        self.collectionIndex = collectionIndex;
    }

    receive("deploy"){

    }

    receive(msg: Mint){
        self.requireOwner();
        let nftItemInit: StateInit = initOf NftItem(msg.newOwner,self.nextItemIndex);

        //ensure NftCollection still has enough minimum ton for storage        

        let msgValue: Int = context.value();
        let totalBalanceBeforeMsg: Int = myBalance() - msgValue;
        let storageFee: Int = minTonForStorage - min(self.totalBalanceBeforeMsg, minTonForStorage);
        
        msgValue=msgValue - (storageFee+2*gasConsumption);

        send(sendParameters{
            to: contractAddress(nftItemInit),
            value: msgValue,
            mode: SendIgnoreErrors,
            bounce: false,
            body: Transfer{
                newOwner: msg.newOwner;
            }.toCell(),
            code: nftItemInit.code,
            data: nftItemInit.data

    }); 

        send(sendParameters{
            to: self.owner(),
            value: gasConsumption,
            bounce: true,
            mode: SendIgnoreErrors,
            body: newListing{
                 nftAddress:  contractAddress(nftItemInit)
            }.toCell(),
        });
        self.nextItemIndex=self.nextItemIndex+1;
    }

    receive(msg: createNftList){
         send(sendParameters{
            to: msg.nftAddress,
            value: gasConsumption,
            bounce:true,
            mode: SendIgnoreErrors,
            body: changeOwner{
                nftAddress: msg.nftListAddress
            }
         })
    }

}
