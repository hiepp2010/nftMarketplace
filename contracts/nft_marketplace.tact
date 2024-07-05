import "@stdlib/deploy";
import "@stdlib/ownable";

contract NftMarketplace with Deployable, Ownable {
    // Empty init() function is present by default in all Tact contracts
    // since v1.3.0, so{} the following may be omitted:
    //
    // init() {}
    owner: Address;
    nextListingIndex: Int as unit32 ;
    nextCollectionIndex: Int as unit32;

    init(){
        self.owner=sender();
        self.nextListingIndex = 0;
        self.nextCollectionIndex = 0;
    }

    receive(msg: CreateCollection){
         self.requireOwner();
         let NftCollectionInit: StateInit = initOf NftCollection(myAddress(),CreateCollection.collectionContent,self.nextCollectionIndex);
        
         send(sendParameters{
            to: contractAddress(nftCollectionInit),
            value: ton("0.1"),
            mode: SendIgnoreErrors,
            bounce: false,  
            body: "deploy".asComment(),
            code: nftItemInit.code,
            data: nftItemInit.data

    }); 
        self.nextCollectionIndex = self.nextCollectionIndex+1;
    }

    receive(msg: MintCollection){
        self.requireOwner();
    }

    receive(msg: ListingNft){
        let nftListingInit: StateInit = initOf NftListing(myAddress(),msg.marketplaceFee,msg.royaltyFee,msg.expiredDate,msg.ownerAddress);
        
         send(sendParameters{
            to: contractAddress(nftListingInit),
            value: ton("0.1"),
            mode: SendIgnoreErrors,
            bounce: false,  
            body: "deploy".asComment(),
            code: nftItemInit.code,
            data: nftItemInit.data

    }); 
    }

    receive(msg: StakeNft){
        
    }

    receive(msg: AllowAuction){
        send(sendParameters{
            to: contractAddress(nftCollectionInit),
            value: ton("0.1"),
            mode: SendIgnoreErrors,
            bounce: false,  
            body: "allowAuction".asComment(),
            code: nftItemInit.code,
            data: nftItemInit.data
        })
    }

    receive(msg: AllowWhitelist){

    }

    receive(msg: AddWhiteList){
        
    }

    receive(msg: StakeNft){
        
    }

    fun createOffer(){
        
    }

}
