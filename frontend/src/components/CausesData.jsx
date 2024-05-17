import {Component} from "react";
import "./CausesStyles.css";

class CausesData extends Component{
    render(){
        return(
            <div className={this.props.className}>
                <div className="des-text">
                    <h2 className="font-bold">{this.props.heading}</h2>
                    <p>
                        {this.props.text}
                    </p>
                </div>

                <div className="image">
                    <img alt="img" src={this.props.img1}/>
                    <img alt="img" src={this.props.img2}/>
                </div>
            </div>
        );
    }
}

export default CausesData;