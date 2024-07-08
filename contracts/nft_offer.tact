import "@stdlib/deploy";
import "@stdlib/ownable";
import "./messages.tact";

contract NftOffer with Deployable, Ownable{
    owner: Address; 
    royaltyFee: Int as uint32;
    expiredDate: Int as uint32;
    ownerNftAddress: Address;
    expectedPrice: Int as coins;      
    nftAddress: Address;                        
    highestOfferPrice: Int as uint32 = 0;
    highestOfferAddress: Address;
    isAuctionable: Bool = false;
    
    init(owner: Address, royaltyFee: Int, expiredDate: Int , ownerAddress: Address, expectedPrice: Int, nftAddress: Address){
        self.owner=owner;
        self.royaltyFee=royaltyFee;
        self.expiredDate=expiredDate;
        self.expectedPrice=expectedPrice;
        self.ownerNftAddress=ownerAddress;
        self.nftAddress=nftAddress;
        self.highestOfferAddress=owner;
    
    }

    receive("deploy"){
        
    }

    receive("allowAuction"){
        self.requireOwner();
        self.isAuctionable=true 
    }

    receive("finishAuction"){
        self.requireOwner();
        self.transferOwner(self.highestOfferAddress, self.highestOfferPrice);

    }

    receive("cancelAuction"){
        self.requireOwner();
        send(SendParameters{
            to: self.highestOfferAddress,
            value: self.highestOfferPrice,
            bounce:true,
            mode: SendPayGasSeparately + SendIgnoreErrors,
            body: "auction canceled".asComment()
        });
    }

    receive("buyNft"){
        require(context().value>=self.expectedPrice+2*gasConsumption,"not enough ton");
        self.transferOwner(sender(), context().value)
    }

    receive("raiseOffer"){
        require(self.isAuctionable == true, "not allow auctioning");
        require(context().value >= self.highestOfferPrice, "not enough offer");
        send(SendParameters{
            to: self.highestOfferAddress,
            value: self.highestOfferPrice,
            mode: SendPayGasSeparately + SendIgnoreErrors,
            body:"refund offer".asComment()
            
        });

       self.highestOfferAddress=sender();
       self.highestOfferPrice=context().value;
    }

    receive(msg: OwnershipAssigned){
        require(sender()== self.nftAddress, "not from nftAddress");
        //self.nftAddress=sender();
    }

    fun transferOwner(newOwner: Address, price: Int ){
        let marketplaceRoyalty = price * self.royaltyFee / 100;
        send(SendParameters{
            to: self.owner(),
            value: marketplaceRoyalty,
            mode: SendPayGasSeparately + SendIgnoreErrors,
            body:OfferComplete{
                offerAddress: myAddress(),
                nftAddress:self.nftAddress,
                
            }.toCell(),
        });

        send(SendParameters{
            to: self.ownerNftAddress,
            value: price - marketplaceRoyalty,
            mode: SendPayGasSeparately + SendIgnoreErrors,
            body: OfferComplete{
                offerAddress: myAddress(),
                nftAddress:self.nftAddress,
                
            }.toCell()
        });

        send(SendParameters{
            to: self.nftAddress,
            value: gasConsumption,
            mode: SendPayGasSeparately + SendIgnoreErrors,
            body: Transfer{
                query_id: 0,
                new_owner: newOwner,
                response_destination: self.owner(),
                custom_payload: emptyCell(),
                forward_amount: 0,
                forward_payload: emptyCell(),
            }.toCell()
        })

    }
    
} 